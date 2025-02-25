package com.playmusicapplication.VLCApplication.controllers;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.playmusicapplication.VLCApplication.dto.CreateMusicDTO;
import com.playmusicapplication.VLCApplication.dto.MusicDTO;
import com.playmusicapplication.VLCApplication.services.MusicService;

import java.io.IOException;



@RestController
@RequestMapping("/api/music")
public class MusicController {

    private final MusicService musicService;

    public MusicController(MusicService musicService) {
        this.musicService = musicService;
    }

    // Endpoint pour uploader une musique avec image de couverture
    @PostMapping("/upload")
    public ResponseEntity<String> uploadMusic(
            @RequestParam("title") String title,
            @RequestParam("artist") String artist,
            @RequestParam("album") String album,
            @RequestParam("genre") String genre,
            @RequestParam("duration") int duration,
            @RequestParam("likes") int likes,
            @RequestParam("plays") int plays,
            @RequestParam("releaseDate") String releaseDate,
            @RequestParam("userId") Long userId,
            @RequestParam("coverImage") MultipartFile coverImage,
            @RequestParam("file") MultipartFile file) throws IOException {

        String coverImagePath = musicService.saveFile(coverImage, "cover");
        String musicFilePath = musicService.saveFile(file, "music");

        CreateMusicDTO musicDTO = new CreateMusicDTO();
        musicDTO.setTitle(title);
        musicDTO.setArtist(artist);
        musicDTO.setAlbum(album);
        musicDTO.setGenre(genre);
        musicDTO.setCoverImageUrl(coverImagePath);
        musicDTO.setFileUrl(musicFilePath);
        musicDTO.setDuration(duration);
        musicDTO.setLikes(likes);
        musicDTO.setPlays(plays);
        musicDTO.setReleaseDate(releaseDate); // Assurez-vous que cette date est bien parsée
        musicDTO.setUserId(userId);

        musicService.uploadMusic(musicFilePath, coverImagePath, userId);

        return ResponseEntity.status(HttpStatus.CREATED).body("Music uploaded successfully");
    }

    //  Music par ID
    @GetMapping("/{id}")
    public ResponseEntity<MusicDTO> getMusic(@PathVariable Long id) {
        try {
            MusicDTO musicDTO = musicService.getMusic(id);
            return ResponseEntity.ok(musicDTO);
        } catch (Exception e) {
            return ResponseEntity.status(404).body(null);
        }
    }

    // Delete Music by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMusic(@PathVariable Long id) {
        try {
            musicService.deleteMusic(id);
            return ResponseEntity.noContent().build();
        } catch (IOException e) {
            return ResponseEntity.status(500).build();
        }
    }
}
