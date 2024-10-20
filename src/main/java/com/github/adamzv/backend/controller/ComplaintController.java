package com.github.adamzv.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.ComplaintNotFoundException;
import com.github.adamzv.backend.exception.UserNotFoundException;
import com.github.adamzv.backend.helpers.ComplaintHelper;
import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.Complaint;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.repository.AddressRepository;
import com.github.adamzv.backend.repository.ComplaintRepository;
import com.github.adamzv.backend.repository.UserRepository;
import com.github.adamzv.backend.security.annotation.IsModerator;
import com.github.adamzv.backend.security.annotation.IsSpecificUserOrModerator;
import com.github.adamzv.backend.security.annotation.IsUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/complaints")
public class ComplaintController {

    private ComplaintRepository complaintRepository;
    private UserRepository userRepository;
    private AddressRepository addressRepository;

    // use constructor base injection since using @Autowired is not recommended
    public ComplaintController(ComplaintRepository complaintRepository, UserRepository userRepository,
            AddressRepository addressRepository) {
        this.complaintRepository = complaintRepository;
        this.userRepository = userRepository;
        this.addressRepository = addressRepository;
    }

    @GetMapping
    @IsModerator
    public Page<Complaint> getComplaints(@PageableDefault(size = 9) Pageable pageable) {
        return complaintRepository.findAll(pageable);
    }

    @GetMapping("/{id}")
    @IsUser
    @IsSpecificUserOrModerator
    public Complaint getComplaint(@PathVariable Long id) {
        return complaintRepository.findById(id)
                .orElseThrow(() -> new ComplaintNotFoundException(id));
    }

    @GetMapping("/user/{id}")
    @IsUser
    @IsSpecificUserOrModerator
    public ResponseEntity<Page<Complaint>> getUsersComplaints(Pageable pageable, @PathVariable Long id) {
        return ResponseEntity.ok(complaintRepository.findAllByUser_Id(pageable, id));
    }

    @PostMapping
    @IsUser
    public Complaint newComplaint(@RequestParam("complaint") String complaintRequest,
            @RequestParam(value = "file", required = false) MultipartFile multipartImage) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        ComplaintHelper complaintObject = mapper.readValue(complaintRequest, ComplaintHelper.class);

        Complaint complaint = new Complaint();
        complaint.setId(0L);

        User user = userRepository.findById(complaintObject.getUserId())
                .orElseThrow(() -> new UserNotFoundException(complaintObject.getUserId()));
        complaint.setUser(user);

        Address address = addressRepository.findById(complaintObject.getAddressId())
                .orElseThrow(() -> new AddressNotFoundException(complaintObject.getAddressId()));
        complaint.setAddress(address);

        complaint.setDatetime(complaintObject.getDatetime());
        complaint.setText(complaintObject.getText());
        if (multipartImage != null) {
            complaint.setImage(multipartImage.getBytes());
        }
        return complaintRepository.save(complaint);
    }

    @PutMapping("/{id}")
    @IsUser
    @PreAuthorize("newComplaint.user.username == authentication.principal || hasRole('MODERATOR')")
    public Complaint updateComplaint(@PathVariable Long id,
            @RequestParam("complaint") String newComplaint,
            @RequestParam(value = "file", required = false) MultipartFile multipartImage) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        ComplaintHelper newComplaintObject = mapper.readValue(newComplaint, ComplaintHelper.class);

        return complaintRepository.findById(id)
                .map(complaint -> {
                    complaint.setDatetime(newComplaintObject.getDatetime());
                    complaint.setText(newComplaintObject.getText());
                    if (multipartImage != null) {
                        try {
                            complaint.setImage(multipartImage.getBytes());
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    complaint.setUser(userRepository.findById(newComplaintObject.getUserId())
                            .orElseThrow(() -> new UserNotFoundException(newComplaintObject.getUserId())));
                    complaint.setAddress(addressRepository.findById(newComplaintObject.getAddressId())
                            .orElseThrow(() -> new AddressNotFoundException(newComplaintObject.getAddressId())));
                    return complaintRepository.save(complaint);
                })
                .orElseThrow(() -> new ComplaintNotFoundException(id));
    }

    @DeleteMapping("/{id}")
    @IsModerator
    public void deleteComplaint(@PathVariable Long id) {
        complaintRepository.deleteById(id);
    }
}
