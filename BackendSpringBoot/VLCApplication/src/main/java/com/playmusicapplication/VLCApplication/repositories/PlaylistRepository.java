package com.playmusicapplication.VLCApplication.repositories;

import com.playmusicapplication.VLCApplication.models.Playlist;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PlaylistRepository extends JpaRepository<Playlist, Long> {
    List<Playlist> findByUserId(Long userId);
}
