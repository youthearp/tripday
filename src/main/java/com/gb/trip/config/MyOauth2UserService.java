package com.gb.trip.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.gb.trip.model.User;
import com.gb.trip.repository.UserRepository;

@Service
public class MyOauth2UserService extends DefaultOAuth2UserService{

	@Autowired UserRepository userRepository;

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		OAuth2User oauth2User = super.loadUser(userRequest);
		String provider = userRequest.getClientRegistration().getClientId();
		String providerId = oauth2User.getAttribute("sub");
		String username = provider + "_" + providerId;
		String password = null;
		String name = oauth2User.getAttribute("name");
		String email = oauth2User.getAttribute("email");
		String role = "ROLE_USER";
		String nickname = null;
		User user = userRepository.findByUsernameVaild(username);
		if(user == null) {
			user=User.builder()
					.username(username)
					.password(password)
					.nickname(nickname)
					.email(email)
					.enabled(true)
					.role(role)
					.name(name)
					.provider(provider)
					.providerId(providerId)
					.build();
			userRepository.save(user);
		}

		return new MyUserDetails(user,oauth2User.getAttributes());
	}
}
