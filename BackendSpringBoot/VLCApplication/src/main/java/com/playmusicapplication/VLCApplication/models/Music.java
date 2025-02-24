package com.playmusicapplication.VLCApplication.models;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Entity
@Table(name = "music")
public class Music {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String artist;
    private String album;
    private String genre;
    private String coverImageUrl;
    private int duration; // En secondes
    private String fileUrl;
    private int likes;
    private int plays;
    private LocalDateTime releaseDate;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}

