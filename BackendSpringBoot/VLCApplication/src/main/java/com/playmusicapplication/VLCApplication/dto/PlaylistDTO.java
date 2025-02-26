// PlaylistDTO.java
package com.playmusicapplication.VLCApplication.dto;


import java.time.LocalDateTime;
import java.util.List;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class PlaylistDTO {
    private Long id;
    private String name;
    private String description;
    private String coverUrl;
    private LocalDateTime createdAt;
    private Long userId;
    private List<Long> musicIds;
}