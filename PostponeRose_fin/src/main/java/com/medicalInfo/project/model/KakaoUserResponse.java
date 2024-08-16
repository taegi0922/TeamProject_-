package com.medicalInfo.project.model;

import lombok.Data;

@Data
public class KakaoUserResponse {
    private Long id;
    private String connected_at;
    private KakaoAccount kakao_account;

    @Data
    public static class KakaoAccount {
        private Profile profile;
        private String email;

        @Data
        public static class Profile {
            private String nickname;
            private String profile_image_url;
            private String thumbnail_image_url;
        }
    }
}