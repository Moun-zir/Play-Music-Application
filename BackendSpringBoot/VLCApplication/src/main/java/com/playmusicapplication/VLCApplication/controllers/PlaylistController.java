package com.playmusicapplication.VLCApplication.controller;

import com.playmusicapplication.VLCApplication.dto.CreatePlaylistDTO;
import com.playmusicapplication.VLCApplication.dto.PlaylistDTO;
import com.playmusicapplication.VLCApplication.service.PlaylistService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/playlists")
public class PlaylistController {

    @Autowired
    private PlaylistService playlistService;

    // Créer une nouvelle playlist
    @PostMapping("/create")
    public PlaylistDTO createPlaylist(@RequestBody CreatePlaylistDTO createPlaylistDTO) {
        return playlistService.createPlaylist(createPlaylistDTO);
    }

    // Récupérer toutes les playlists
    @GetMapping("/")
    public List<PlaylistDTO> getAllPlaylists() {
        return playlistService.getAllPlaylists();
    }

    // Récupérer une playlist par son ID
    @GetMapping("/{id}")
    public PlaylistDTO getPlaylistById(@PathVariable Long id) {
        return playlistService.getPlaylistById(id);
    }

    // Mettre à jour une playlist existante
    @PutMapping("/{id}")
    public PlaylistDTO updatePlaylist(@PathVariable Long id, @RequestBody CreatePlaylistDTO createPlaylistDTO) {
        return playlistService.updatePlaylist(id, createPlaylistDTO);
    }

    // Supprimer une playlist
    @DeleteMapping("/{id}")
    public void deletePlaylist(@PathVariable Long id) {
        playlistService.deletePlaylist(id);
    }
}
