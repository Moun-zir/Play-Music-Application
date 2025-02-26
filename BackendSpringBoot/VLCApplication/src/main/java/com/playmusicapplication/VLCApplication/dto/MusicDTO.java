// MusicDTO.java
package com.playmusicapplication.VLCApplication.dto;


import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class MusicDTO {
    private Long id;
    private String title;
    private String artist;
    private String album;
    private String genre;
    private String coverImageUrl;
    private int duration;
    private String fileUrl;
    private int likes;
    private int plays;
    private LocalDateTime releaseDate;
    private Long userId;
}

