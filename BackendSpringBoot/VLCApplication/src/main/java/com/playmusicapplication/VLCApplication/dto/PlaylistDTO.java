package com.playmusicapplication.VLCApplication.dto;

import java.time.LocalDateTime;
import java.util.List;

public class PlaylistDTO {
    private Long id;
    private String name;
    private String description;
    private byte[] coverImage;
    private LocalDateTime createdAt;
    private Long userId;
    private List<Long> musicContentIds;

    // Getters and setters for all fields

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

    // Getters et setters
    public byte[] getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(byte[] coverImage) {
        this.coverImage = coverImage;
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
}