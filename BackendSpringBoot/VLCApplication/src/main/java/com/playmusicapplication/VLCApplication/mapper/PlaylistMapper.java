package com.playmusicapplication.VLCApplication.mapper;

import com.playmusicapplication.VLCApplication.dto.PlaylistDTO;
import com.playmusicapplication.VLCApplication.models.Playlist;
import com.playmusicapplication.VLCApplication.models.PlaylistContentMusic;

import java.util.List;
import java.util.stream.Collectors;

public class PlaylistMapper {

    public static Playlist toEntity(PlaylistDTO playlistDTO) {
        Playlist playlist = new Playlist();
        playlist.setName(playlistDTO.getName());
        playlist.setDescription(playlistDTO.getDescription());
        playlist.setCoverImage(playlistDTO.getCoverImage());

        if (playlistDTO.getMusicContentIds() != null) {
            List<PlaylistContentMusic> musicContent = playlistDTO.getMusicContentIds().stream()
                    .map(id -> new PlaylistContentMusic(id))
                    .collect(Collectors.toList());
            playlist.setMusicContent(musicContent);
        }

        return playlist;
    }

    public static PlaylistDTO toDTO(Playlist playlist) {
        PlaylistDTO playlistDTO = new PlaylistDTO();
        playlistDTO.setId(playlist.getId());
        playlistDTO.setName(playlist.getName());
        playlistDTO.setDescription(playlist.getDescription());
        playlistDTO.setCoverImage(playlist.getCoverImage());
        playlistDTO.setCreatedAt(playlist.getCreatedAt());
        playlistDTO.setUserId(playlist.getUser().getId());

        if (playlist.getMusicContent() != null) {
            List<Long> musicContentIds = playlist.getMusicContent().stream()
                    .map(PlaylistContentMusic::getId)
                    .collect(Collectors.toList());
            playlistDTO.setMusicContentIds(musicContentIds);
        }

        return playlistDTO;
    }
}
