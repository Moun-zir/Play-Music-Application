package com.playmusicapplication.VLCApplication.dto;

import java.time.LocalDateTime;
import java.util.List;

public class PlaylistDTO {

    private Long id;
    private String name;
    private String description;
    private String coverUrl;
    private LocalDateTime createdAt;
    private Long userId; // L'ID de l'utilisateur
    private List<Long> musicContentIds; // Liste des IDs des musiques dans la playlist
    private List<Long> videoContentIds; // Liste des IDs des vidéos dans la playlist

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
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
