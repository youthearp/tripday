package com.gb.trip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;

import com.gb.trip.model.User;
import com.gb.trip.model.UserRegistration;
import com.gb.trip.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	UserRepository userRepository;

	@Autowired
	PasswordEncoder passwordEncoder;


	@Transactional(readOnly = true)
	public User findUser(String username) {
		User user = userRepository.findByUsername(username).orElseGet(()->{
			return new User();
		});
		return user;
	}

	@Transactional
	public List<User> findAll() {
		// TODO Auto-generated method stub
		return userRepository.findAll();
	}


	public boolean hasErrors(UserRegistration userRegistration, BindingResult bindingResult) {
        if (bindingResult.hasErrors())
            return true;
        if (userRegistration.getPasswd1().equals(userRegistration.getPasswd2()) == false) {
            bindingResult.rejectValue("passwd2", null, "비밀번호가 일치하지 않습니다.");
            return true;
        }
        User user = userRepository.findByUsernameVaild(userRegistration.getUsername());
        if (user != null) {
            bindingResult.rejectValue("username", null, "사용자 아이디가 중복됩니다.");
            return true;
        }
        User user2 = userRepository.findByNicknameVaild(userRegistration.getNickname());
        if (user2 != null) {
        	bindingResult.rejectValue("nickname", null, "사용자 닉네임이 중복됩니다.");
        	return true;
        }

        return false;
    }



    public User createDto(UserRegistration userRegistration) {
        User user = new User();
        user.setUsername(userRegistration.getUsername());
        user.setEmail(userRegistration.getEmail());
        user.setPassword(passwordEncoder.encode(userRegistration.getPasswd1()));
        user.setName(userRegistration.getName());
        user.setEnabled(true);
        user.setRole("ROLE_USER");
        user.setNickname(userRegistration.getNickname());
        user.setProvider(null);
        user.setProviderId(null);
        return user;
    }


	@Transactional
    public int save(UserRegistration userRegistration) {
        User user = createDto(userRegistration);
		try {
			userRepository.save(user);
			return 1;
		} catch (Exception e) {
			return -1;
		}

    }





	@Transactional
	public void updateUser(User user) {
		// 수정시에는 영속성 컨텍스트 User 오브젝트를 영속화시키고, 영속화된 User 오브젝트를 수정
		// select를 해서 User오브젝트를 DB로 부터 가져오는 이유는 영속화를 하기 위해서!!
		// 영속화된 오브젝트를 변경하면 자동으로 DB에 update문을 날려주거든요.
		User persistance = userRepository.findById(user.getId()).orElseThrow(()->{
			return new IllegalArgumentException("회원 찾기 실패");
		});

		// Validate 체크 => oauth 필드에 값이 없으면 수정 가능
		if(persistance.getProvider() == null || persistance.getProvider().equals("")) {
			String rawPassword = user.getPassword();
			String encPassword = passwordEncoder.encode(rawPassword);
			persistance.setPassword(encPassword);
			persistance.setEmail(user.getEmail());
		}

		// 회원수정 함수 종료시 = 서비스 종료 = 트랜잭션 종료 = commit 이 자동으로 됩니다.
		// 영속화된 persistance 객체의 변화가 감지되면 더티체킹이 되어 update문을 날려줌.
	}


	@Transactional
	public void updateUserNickname(User user) {
		User persistance = userRepository.findById(user.getId()).orElseThrow(() -> {
			return new IllegalArgumentException("회원 찾기 실패");
		});

		if (userRepository.findByNicknameVaild(user.getNickname()) == null) {
			persistance.setNickname(user.getNickname());
		} else {
			throw new IllegalArgumentException("닉네임 중복");
		}

	}


}
