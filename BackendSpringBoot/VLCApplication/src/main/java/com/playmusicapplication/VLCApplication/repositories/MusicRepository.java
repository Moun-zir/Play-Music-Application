package com.playmusicapplication.VLCApplication.repositories;

import com.playmusicapplication.VLCApplication.models.Music;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MusicRepository extends JpaRepository<Music, Long> {
}