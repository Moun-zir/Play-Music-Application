package com.playmusicapplication.VLCApplication.mapper;

import com.playmusicapplication.VLCApplication.models.Playlist;
import com.playmusicapplication.VLCApplication.dto.CreatePlaylistDTO;
import com.playmusicapplication.VLCApplication.dto.PlaylistDTO;
import com.playmusicapplication.VLCApplication.models.PlaylistContentMusic;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

public class PlaylistMapper {

    // Convertir CreatePlaylistDTO en Playlist
    public static Playlist toEntity(CreatePlaylistDTO createPlaylistDTO) {
        Playlist playlist = new Playlist();
        playlist.setName(createPlaylistDTO.getName());
        playlist.setDescription(createPlaylistDTO.getDescription());
        playlist.setCoverUrl(createPlaylistDTO.getCoverUrl());
        playlist.setCreatedAt(LocalDateTime.now()); // On définit l'heure actuelle comme date de création
        // L'utilisateur est souvent récupéré depuis un service utilisateur
        // playlist.setUser(userService.findById(createPlaylistDTO.getUserId()));

        // Ajouter les musiques et vidéos à la playlist
        List<PlaylistContentMusic> musicContent = createPlaylistDTO.getMusicContentIds().stream()
                .map(id -> new PlaylistContentMusic(getId)) // Ici, tu dois mapper selon ta logique métier
                .collect(Collectors.toList());

        

        playlist.setMusicContent(musicContent);
       

        return playlist;
    }

    // Convertir Playlist en PlaylistDTO
    public static PlaylistDTO toDTO(Playlist playlist) {
        PlaylistDTO playlistDTO = new PlaylistDTO();
        playlistDTO.setId(playlist.getId());
        playlistDTO.setName(playlist.getName());
        playlistDTO.setDescription(playlist.getDescription());
        playlistDTO.setCoverUrl(playlist.getCoverUrl());
        playlistDTO.setCreatedAt(playlist.getCreatedAt());
        playlistDTO.setUserId(playlist.getUser().getId()); // ID de l'utilisateur associé à la playlist

        // Ajouter les IDs des musiques et vidéos
        List<Long> musicContentIds = playlist.getMusicContent().stream()
                .map(PlaylistContentMusic::getId)
                .collect(Collectors.toList());

       

        playlistDTO.setMusicContentIds(musicContentIds);
     

        return playlistDTO;
    }
}
