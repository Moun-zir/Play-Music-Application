package com.playmusicapplication.VLCApplication.services;

import com.playmusicapplication.VLCApplication.models.Playlist;
import com.playmusicapplication.VLCApplication.dto.CreatePlaylistDTO;
import com.playmusicapplication.VLCApplication.dto.PlaylistDTO;
import com.playmusicapplication.VLCApplication.mapper.PlaylistMapper;

import com.playmusicapplication.VLCApplication.repositories.PlaylistRepository;
import com.playmusicapplication.VLCApplication.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PlaylistService {

    @Autowired
    private PlaylistRepository playlistRepository;

    @Autowired
    private UserRepository userRepository; // Pour récupérer l'utilisateur si nécessaire

    // Créer une nouvelle playlist
    public PlaylistDTO createPlaylist(CreatePlaylistDTO createPlaylistDTO) {
        Playlist playlist = PlaylistMapper.toEntity(createPlaylistDTO); // Mapper le DTO en entité
        playlist = playlistRepository.save(playlist); // Sauvegarder dans la base de données
        return PlaylistMapper.toDTO(playlist); // Retourner le DTO de la playlist sauvegardée
    }

    // Récupérer toutes les playlists
    public List<PlaylistDTO> getAllPlaylists() {
        List<Playlist> playlistList = playlistRepository.findAll();
        return playlistList.stream()
                .map(PlaylistMapper::toDTO)
                .collect(Collectors.toList());
    }

    // Récupérer une playlist par son ID
    public PlaylistDTO getPlaylistById(Long id) {
        Playlist playlist = playlistRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Playlist not found with id " + id));
        return PlaylistMapper.toDTO(playlist);
    }

    // Mettre à jour une playlist
    public PlaylistDTO updatePlaylist(Long id, CreatePlaylistDTO createPlaylistDTO) {
        Playlist existingPlaylist = playlistRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Playlist not found with id " + id));
        existingPlaylist = PlaylistMapper.toEntity(createPlaylistDTO);
        playlistRepository.save(existingPlaylist);
        return PlaylistMapper.toDTO(existingPlaylist);
    }

    // Supprimer une playlist
    public void deletePlaylist(Long id) {
        Playlist playlist = playlistRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Playlist not found with id " + id));
        playlistRepository.delete(playlist);
    }
}
