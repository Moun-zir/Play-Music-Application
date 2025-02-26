package com.playmusicapplication.VLCApplication.controllers;

import com.playmusicapplication.VLCApplication.dto.PlaylistDTO;
import com.playmusicapplication.VLCApplication.services.PlaylistService;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import java.io.IOException;
import java.util.List;


@RestController
@RequestMapping("/api/playlists")
@RequiredArgsConstructor
public class PlaylistController {

    private final PlaylistService playlistService;

    @PostMapping(consumes = "multipart/form-data")
    public ResponseEntity<PlaylistDTO> createPlaylist(
        @RequestParam("name") String name,
        @RequestParam("description") String description,
        @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
        @RequestParam("userId") Long userId
    ) throws IOException {
        return ResponseEntity.ok(playlistService.createPlaylist(name, description, coverImage, userId));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<PlaylistDTO>> getUserPlaylists(@PathVariable Long userId) {
        List<PlaylistDTO> playlists = playlistService.getUserPlaylists(userId);
        return ResponseEntity.ok(playlists);
    }

//     @PutMapping("/{id}")
// public ResponseEntity<PlaylistDTO> updatePlaylist(@PathVariable Long id, @Valid @RequestBody PlaylistDTO playlistDTO) {
//     return ResponseEntity.ok(playlistService.updatePlaylist(id, playlistDTO));
// }

@DeleteMapping("/{id}")
public ResponseEntity<Void> deletePlaylist(@PathVariable Long id) {
    playlistService.deletePlaylist(id);
    return ResponseEntity.noContent().build();
}

}
