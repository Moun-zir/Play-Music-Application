package com.playmusicapplication.VLCApplication.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class MusicService {

    @Value("${storage.mode}")
    private String storageMode;

    @Value("${storage.local.path}")
    private String localStoragePath;

    @Value("${storage.s3.bucket-name}")
    private String s3BucketName;

    @Value("${storage.s3.access-key}")
    private String s3AccessKey;

    @Value("${storage.s3.secret-key}")
    private String s3SecretKey;

    private final musicRepository musicRepository;

    // Constructor injection for MusicRepository
    public MusicService(MusicRepository musicRepository) {
        this.musicRepository = musicRepository;
    }

    // Upload Music and Cover Image
    public MusicDTO uploadMusic(MultipartFile musicFile, MultipartFile coverImageFile, Long userId) throws IOException {
        String musicFilename = musicFile.getOriginalFilename();
        String coverImageFilename = coverImageFile.getOriginalFilename();
        String musicFileUrl = "";
        String coverImageUrl = "";

        if ("local".equalsIgnoreCase(storageMode)) {
            musicFileUrl = uploadToLocal(musicFile, musicFilename);
            coverImageUrl = uploadToLocal(coverImageFile, coverImageFilename);
        } else if ("s3".equalsIgnoreCase(storageMode)) {
            musicFileUrl = uploadToS3(musicFile, musicFilename);
            coverImageUrl = uploadToS3(coverImageFile, coverImageFilename);
        }

        Music music = new Music();
        music.setTitle("Sample Title");  // Set other properties based on DTO
        music.setArtist("Sample Artist");
        music.setAlbum("Sample Album");
        music.setGenre("Sample Genre");
        music.setCoverImageUrl(coverImageUrl);  // Set the cover image URL
        music.setFileUrl(musicFileUrl);  // Set the music file URL
        music.setLikes(0);
        music.setPlays(0);
        music.setReleaseDate(LocalDateTime.now());
        music.setUser(new User(userId)); // Assuming you have a User object, set the userId

        musicRepository.save(music);

        return new MusicDTO(music);
    }

    private MusicDTO saveFile(MultipartFile file, String type) throws IOException {
        String filename = file.getOriginalFilename();
        String fileUrl = "";

        if ("local".equalsIgnoreCase(storageMode)) {
            fileUrl = uploadToLocal(file, filename);
        } else if ("s3".equalsIgnoreCase(storageMode)) {
            fileUrl = uploadToS3(file, filename);
        }

        Music music = new Music();
        music.setTitle("Sample Title");  // Set other properties based on DTO
        music.setArtist("Sample Artist");
        music.setAlbum("Sample Album");
        music.setGenre("Sample Genre");
        music.setCoverImageUrl("Sample Cover Image URL");  // Set the cover image URL
        music.setFileUrl(fileUrl);  // Set the music file URL
        music.setLikes(0);
        music.setPlays(0);
        music.setReleaseDate(LocalDateTime.now());
        music.setUser(new User(1L)); // Assuming you have a User object, set the userId

        musicRepository.save(music);

        return new MusicDTO(music);
    }

    private MusicDTO getMusic(Long id) {
        Optional<Music> music = musicRepository.findById(id);
        if (music.isPresent()) {
            return new MusicDTO(music.get());
        } else {
            throw new RuntimeException("Music not found");
        }
    }

    // Method for local file storage
    private String uploadToLocal(MultipartFile file, String filename) throws IOException {
        Path rootLocation = Paths.get(localStoragePath);
        Files.copy(file.getInputStream(), rootLocation.resolve(filename));
        return "/uploads/music/" + filename;
    }

    // Method for S3 file storage (example with AWS SDK)
    private String uploadToS3(MultipartFile file, String filename) {
        AmazonS3 s3Client = AmazonS3Client.builder()
                .credentialsProvider(StaticCredentialsProvider.create(AwsBasicCredentials.create(s3AccessKey, s3SecretKey)))
                .region(Region.US_EAST_1) 
                .build();

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentType(file.getContentType());
        PutObjectRequest request = PutObjectRequest.builder()
                .bucket(s3BucketName)
                .key(filename)
                .metadata(metadata)
                .build();

        s3Client.putObject(request, RequestBody.fromBytes(file.getBytes()));

        return s3Client.utilities().getUrl(GetUrlRequest.builder()
                .bucket(s3BucketName)
                .key(filename)
                .build()).toString();
    }

   
}
