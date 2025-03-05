// MusicMapper.java
package com.playmusicapplication.VLCApplication.mapper;

import com.playmusicapplication.VLCApplication.dto.MusicDTO;
import com.playmusicapplication.VLCApplication.models.Music;
import org.springframework.stereotype.Component;

@Component
public class MusicMapper {
    public MusicDTO toDto(Music music) {
        MusicDTO dto = new MusicDTO();
        dto.setId(music.getId());
        dto.setTitle(music.getTitle());
        dto.setArtist(music.getArtist());
        dto.setAlbum(music.getAlbum());
        dto.setGenre(music.getGenre());
    
        dto.setDuration(music.getDuration());
        dto.setFileUrl(music.getFileUrl());
        dto.setLikes(music.getLikes());
        dto.setPlays(music.getPlays());
        dto.setReleaseDate(music.getReleaseDate());
    
        // Vérifie si le user est null
        dto.setUserId(music.getUser() != null ? music.getUser().getId() : null);
    
        // Vérifie que l'URL n'est pas déjà complète
        if (music.getCoverImageUrl() != null && !music.getCoverImageUrl().startsWith("http")) {
            dto.setCoverImageUrl("http://localhost:8080/uploads/" + music.getCoverImageUrl());


        } else {
            dto.setCoverImageUrl(music.getCoverImageUrl());
        }
    
        return dto;
    }
    

    public Music toEntity(MusicDTO dto) {
        Music music = new Music();
        music.setTitle(dto.getTitle());
        music.setArtist(dto.getArtist());
        music.setAlbum(dto.getAlbum());
        music.setGenre(dto.getGenre());
    
        // Ne pas réutiliser une URL complète, uniquement le nom du fichier
        if (dto.getCoverImageUrl() != null && dto.getCoverImageUrl().startsWith("http")) {
            String[] parts = dto.getCoverImageUrl().split("/uploads/");
            if (parts.length > 1) {
                music.setCoverImageUrl(parts[1]); // Ne garde que le nom du fichier
            }
        } else {
            music.setCoverImageUrl(dto.getCoverImageUrl());
        }
    
        music.setDuration(dto.getDuration());
        music.setFileUrl(dto.getFileUrl());
        music.setLikes(dto.getLikes());
        music.setPlays(dto.getPlays());
        music.setReleaseDate(dto.getReleaseDate());
        return music;
    }
    
}