package com.playmusicapplication.VLCApplication.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.playmusicapplication.VLCApplication.dto.MusicDTO;
import com.playmusicapplication.VLCApplication.services.MusicService;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/music")
public class MusicController {
    private final MusicService musicService;

    public MusicController(MusicService musicService) {
        this.musicService = musicService;
    }

    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<MusicDTO> uploadMusic(
            @RequestPart(value = "musicDTO") String musicDTOJson,
            @RequestPart("file") MultipartFile file,
            @RequestPart("coverImage") MultipartFile coverImage) throws JsonProcessingException {
    
        // Cela pourrait aussi être utile pour déboguer
        System.out.println("musicDTOJson: " + musicDTOJson);
    
        ObjectMapper objectMapper = new ObjectMapper();
        MusicDTO musicDTO = objectMapper.readValue(musicDTOJson, MusicDTO.class);
    
        System.out.println("Requête reçue : musicDTO=" + musicDTOJson);
        System.out.println("Fichier audio : " + file.getOriginalFilename());
        System.out.println("Image de couverture : " + coverImage.getOriginalFilename());

        // Envoie le service pour traitement
        return ResponseEntity.ok(musicService.uploadMusic(musicDTO, file, coverImage));
    }
    
    


    @PostMapping("/{id}/like")
    public ResponseEntity<MusicDTO> likeMusic(@PathVariable Long id) {
        return ResponseEntity.ok(musicService.likeMusic(id));
    }
    @GetMapping
    public ResponseEntity<List<MusicDTO>> getAllMusic() {
        List<MusicDTO> musicDTOList = musicService.getAllMusic();
        return ResponseEntity.ok(musicDTOList);
    }
    @GetMapping("/{id}")
    public ResponseEntity<MusicDTO> getMusic(@PathVariable Long id) {
        return ResponseEntity.ok(musicService.getMusic(id));
    }
}