package com.playmusicapplication.VLCApplication.services;

import com.playmusicapplication.VLCApplication.dto.PlaylistDTO;
import com.playmusicapplication.VLCApplication.mapper.PlaylistMapper;
import com.playmusicapplication.VLCApplication.models.Playlist;
import com.playmusicapplication.VLCApplication.models.User;
import com.playmusicapplication.VLCApplication.repositories.PlaylistRepository;
import com.playmusicapplication.VLCApplication.repositories.UserRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.stream.Collectors;
import java.util.List;


@Service
@RequiredArgsConstructor
public class PlaylistService {

    private final PlaylistRepository playlistRepository;
    private final UserRepository userRepository;

    @Transactional
   public PlaylistDTO createPlaylist(String name, String description, MultipartFile coverImage, Long userId) throws IOException {
        Playlist playlist = new Playlist();
        playlist.setName(name);
        playlist.setDescription(description);
        playlist.setCreatedAt(LocalDateTime.now());

        if (coverImage != null && !coverImage.isEmpty()) {
            playlist.setCoverImage(coverImage.getBytes());
        }

        return convertToDto(playlistRepository.save(playlist));
    }

    private PlaylistDTO convertToDto(Playlist playlist) {
        PlaylistDTO dto = new PlaylistDTO();
        dto.setId(playlist.getId());
        dto.setName(playlist.getName());
        dto.setDescription(playlist.getDescription());
        dto.setCoverImage(playlist.getCoverImage());
        dto.setCreatedAt(playlist.getCreatedAt());
        dto.setUserId(playlist.getUser().getId());
        return dto;
    }

    @Transactional(readOnly = true)
    public List<PlaylistDTO> getUserPlaylists(Long userId) {
    return playlistRepository.findByUserId(userId)
            .stream()
            .map(PlaylistMapper::toDTO)
            .collect(Collectors.toList());
}

@Transactional
public PlaylistDTO updatePlaylist(Long id, PlaylistDTO playlistDTO) {
    Playlist playlist = playlistRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Playlist non trouvée"));

    playlist.setName(playlistDTO.getName());
    playlist.setDescription(playlistDTO.getDescription());
    playlist.setCoverImage(playlistDTO.getCoverImage());

    return PlaylistMapper.toDTO(playlistRepository.save(playlist));
}

@Transactional
public void deletePlaylist(Long id) {
    if (!playlistRepository.existsById(id)) {
        throw new RuntimeException("Playlist non trouvée");
    }
    playlistRepository.deleteById(id);
}

}
