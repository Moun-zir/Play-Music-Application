package com.playmusicapplication.VLCApplication.services;

import com.playmusicapplication.VLCApplication.dto.MusicDTO;
import com.playmusicapplication.VLCApplication.mapper.MusicMapper;
import com.playmusicapplication.VLCApplication.models.Music;
import com.playmusicapplication.VLCApplication.models.User;
import com.playmusicapplication.VLCApplication.repositories.MusicRepository;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MusicService {
    private final MusicRepository musicRepository;
    private final MusicMapper musicMapper;
    private final FileStorageService fileStorageService;

    public MusicService(MusicRepository musicRepository, MusicMapper musicMapper, 
                       FileStorageService fileStorageService) {
        this.musicRepository = musicRepository;
        this.musicMapper = musicMapper;
        this.fileStorageService = fileStorageService;
    }

    public MusicDTO uploadMusic(MusicDTO musicDTO, MultipartFile file, MultipartFile coverImage) {
        if (file.isEmpty() || coverImage.isEmpty()) {
            throw new IllegalArgumentException("Le fichier audio et l'image de couverture sont obligatoires !");
        }

        String fileUrl = fileStorageService.storeFile(file);
        String coverUrl = fileStorageService.storeFile(coverImage);

        Music music = musicMapper.toEntity(musicDTO);
        music.setFileUrl(fileUrl);
        music.setCoverImageUrl(coverUrl);
        music.setLikes(0);
        music.setPlays(0);

        if (music.getUser() == null) {
            User defaultUser = new User();
            defaultUser.setId(0L);  // ou l'id d'un utilisateur système
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
}