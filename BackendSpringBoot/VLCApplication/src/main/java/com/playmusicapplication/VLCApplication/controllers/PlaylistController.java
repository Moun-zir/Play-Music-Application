package com.playmusicapplication.VLCApplication.controllers;

import com.playmusicapplication.VLCApplication.dto.PlaylistDTO;
import com.playmusicapplication.VLCApplication.services.PlaylistService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/playlists")
public class PlaylistController {
    private final PlaylistService playlistService;

    public PlaylistController(PlaylistService playlistService) {
        this.playlistService = playlistService;
    }

    @PostMapping
    public ResponseEntity<PlaylistDTO> createPlaylist(@RequestBody PlaylistDTO playlistDTO) {
        return ResponseEntity.ok(playlistService.createPlaylist(playlistDTO));
    }
}