package com.playmusicapplication.VLCApplication.dto;	
import com.playmusicapplication.VLCApplication.models.Music;

public class MusicDTO {
    private Long id; 
    private String title;
    private String artist;
    private String album;
    private String genre;
    private String coverImageUrl;
    private String fileUrl;

    // Constructor, getters and setters
    public MusicDTO(Music music) {
        this.id = music.getId();
        this.title = music.getTitle();
        this.artist = music.getArtist();
        this.album = music.getAlbum();
        this.genre = music.getGenre();
        this.coverImageUrl = music.getCoverImageUrl();
        this.fileUrl = music.getFileUrl();
    }
    // Getters and Setters

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
   
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }
    public String getAlbum() {
        return album;
    }
    public void setAlbum(String album) {
        this.album = album;
    }
    public String getGenre() {
        return genre;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }
    public String getCoverImageUrl() {
        return coverImageUrl;
    }
    public void setCoverImageUrl(String coverImageUrl) {
        this.coverImageUrl = coverImageUrl;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }
}
