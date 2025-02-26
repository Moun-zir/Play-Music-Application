package com.playmusicapplication.VLCApplication.repositories;

import com.playmusicapplication.VLCApplication.models.Playlist;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlaylistRepository extends JpaRepository<Playlist, Long> {
}