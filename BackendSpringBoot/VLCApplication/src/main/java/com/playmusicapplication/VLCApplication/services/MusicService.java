package com.playmusicapplication.VLCApplication.services;

import com.playmusicapplication.VLCApplication.dto.MusicDTO;
import com.playmusicapplication.VLCApplication.mapper.MusicMapper;
import com.playmusicapplication.VLCApplication.models.Music;
import com.playmusicapplication.VLCApplication.models.User;
import com.playmusicapplication.VLCApplication.repositories.MusicRepository;
import com.playmusicapplication.VLCApplication.repositories.UserRepository;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MusicService {
    private final MusicRepository musicRepository;
    private final MusicMapper musicMapper;
    private final FileStorageService fileStorageService;
    private final UserRepository userRepository;


    public MusicService(MusicRepository musicRepository, MusicMapper musicMapper, 
                       FileStorageService fileStorageService, UserRepository userRepository) {
        this.musicRepository = musicRepository;
        this.musicMapper = musicMapper;
        this.fileStorageService = fileStorageService;
        this.userRepository = userRepository;
    }

    public MusicDTO uploadMusic(MusicDTO musicDTO, MultipartFile file, MultipartFile coverImage) {
        if (file.isEmpty() || coverImage.isEmpty()) {
            throw new IllegalArgumentException("Le fichier audio et l'image de couverture sont obligatoires !");
        }
    
        String fileUrl = fileStorageService.storeFile(file);
        fileUrl = fileUrl.substring(fileUrl.lastIndexOf("\\") + 1);
        String coverUrl = fileStorageService.storeFile(coverImage);
        coverUrl = coverUrl.substring(coverUrl.lastIndexOf("\\") + 1);
    
        Music music = musicMapper.toEntity(musicDTO);
    
        // Vérifie si les URLs sont déjà définies
        if (music.getFileUrl() == null || music.getFileUrl().isEmpty()) {
            music.setFileUrl(fileUrl);
        }
        if (music.getCoverImageUrl() == null || music.getCoverImageUrl().isEmpty()) {
            music.setCoverImageUrl(coverUrl);
        }
    
        music.setLikes(0);
        music.setPlays(0);
    
        if (music.getUser() == null) {
            User defaultUser = userRepository.findById(1L)
                .orElseThrow(() -> new RuntimeException("Utilisateur par défaut introuvable"));
            music.setUser(defaultUser);
        }
    
        return musicMapper.toDto(musicRepository.save(music));
    }
    

    public MusicDTO likeMusic(Long musicId) {
        Music music = musicRepository.findById(musicId)
            .orElseThrow(() -> new RuntimeException("Music not found"));
        music.setLikes(music.getLikes() + 1);
        return musicMapper.toDto(musicRepository.save(music));
    }
    public List<MusicDTO> getAllMusic() {
        List<Music> musicList = musicRepository.findAll();
        return musicList.stream()
                        .map(musicMapper::toDto)
                        .collect(Collectors.toList());
    }
    public MusicDTO getMusic(Long id) {
        Music music = musicRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Music not found"));
        return musicMapper.toDto(music);
    }
}