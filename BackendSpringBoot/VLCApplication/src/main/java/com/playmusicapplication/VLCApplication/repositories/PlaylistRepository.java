package com.playmusicapplication.VLCApplication.repositories;

import com.playmusicapplication.VLCApplication.models.Playlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlaylistRepository extends JpaRepository<Playlist, Long> {
    // Ici, tu peux ajouter des méthodes spécifiques si nécessaire
    // Par exemple, récupérer une playlist par son nom
    Playlist findByName(String name);
}
