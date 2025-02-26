// PlaylistService.java
package com.playmusicapplication.VLCApplication.services;

import com.playmusicapplication.VLCApplication.dto.PlaylistDTO;
import com.playmusicapplication.VLCApplication.models.Playlist;
import com.playmusicapplication.VLCApplication.repositories.PlaylistRepository;

import java.time.LocalDateTime;

import org.springframework.stereotype.Service;

@Service
public class PlaylistService {
    private final PlaylistRepository playlistRepository;

    public PlaylistService(PlaylistRepository playlistRepository) {
        this.playlistRepository = playlistRepository;
    }

    public PlaylistDTO createPlaylist(PlaylistDTO playlistDTO) {
        Playlist playlist = new Playlist();
        playlist.setName(playlistDTO.getName());
        playlist.setDescription(playlistDTO.getDescription());
        playlist.setCoverUrl(playlistDTO.getCoverUrl());
        playlist.setCreatedAt(LocalDateTime.now());
        
        return convertToDto(playlistRepository.save(playlist));
    }

    private PlaylistDTO convertToDto(Playlist playlist) {
        PlaylistDTO dto = new PlaylistDTO();
        dto.setId(playlist.getId());
        dto.setName(playlist.getName());
        dto.setDescription(playlist.getDescription());
        dto.setCoverUrl(playlist.getCoverUrl());
        dto.setCreatedAt(playlist.getCreatedAt());
        dto.setUserId(playlist.getUser().getId());
        return dto;
    }
}