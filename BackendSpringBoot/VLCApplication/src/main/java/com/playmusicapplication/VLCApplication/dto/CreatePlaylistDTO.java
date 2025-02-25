package com.playmusicapplication.VLCApplication.dto;

import java.time.LocalDateTime;
import java.util.List;

public class CreatePlaylistDTO {

    private String name;
    private String description;
    private String coverUrl;
    private Long userId; // L'ID de l'utilisateur
    private List<Long> musicContentIds; // Liste des IDs des musiques
    private List<Long> videoContentIds; // Liste des IDs des vidéos

    // Getters et Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public List<Long> getMusicContentIds() {
        return musicContentIds;
    }

    public void setMusicContentIds(List<Long> musicContentIds) {
        this.musicContentIds = musicContentIds;
    }

    public List<Long> getVideoContentIds() {
        return videoContentIds;
    }

    public void setVideoContentIds(List<Long> videoContentIds) {
        this.videoContentIds = videoContentIds;
    }
}
