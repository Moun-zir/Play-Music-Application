package com.playmusicapplication.VLCApplication.mapper;

import com.playmusicapplication.VLCApplication.dto.MusicDTO;
import com.playmusicapplication.VLCApplication.models.Music;

public class MusicMapper {

    public static MusicDTO toDTO(Music music) {
        MusicDTO dto = new MusicDTO();
        dto.setId(music.getId());
        dto.setTitle(music.getTitle());
        dto.setArtist(music.getArtist());
        dto.setAlbum(music.getAlbum());
        dto.setGenre(music.getGenre());
        dto.setCoverImageUrl(music.getCoverImageUrl());
        dto.setDuration(music.getDuration());
        dto.setFileUrl(music.getFileUrl());
        dto.setLikes(music.getLikes());
        dto.setPlays(music.getPlays());
        dto.setReleaseDate(music.getReleaseDate());
        dto.setUserId(music.getUser() != null ? music.getUser().getId() : null); // Si l'utilisateur est présent
        return dto;
    }

    public static Music toEntity(MusicDTO dto) {
        Music music = new Music();
      
        music.setTitle(dto.getTitle());
        music.setArtist(dto.getArtist());
        music.setAlbum(dto.getAlbum());
        music.setGenre(dto.getGenre());
        music.setCoverImageUrl(dto.getCoverImageUrl());
        music.setDuration(dto.getDuration());
        music.setFileUrl(dto.getFileUrl());
        music.setLikes(dto.getLikes());
        music.setPlays(dto.getPlays());
        music.setReleaseDate(dto.getReleaseDate());
        // Ici, on suppose que l'on aura l'utilisateur quelque part pour le peupler
        return music;
    }
}
