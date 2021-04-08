package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.AddressNotFoundException;
import com.github.adamzv.backend.exception.ComplaintNotFoundException;
import com.github.adamzv.backend.exception.UserNotFoundException;
import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.Complaint;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.repository.AddressRepository;
import com.github.adamzv.backend.repository.ComplaintRepository;
import com.github.adamzv.backend.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/complaints")
public class ComplaintController {

    private ComplaintRepository complaintRepository;
    private UserRepository userRepository;
    private AddressRepository addressRepository;

    // use constructor base injection since using @Autowired is not recommended
    public ComplaintController(ComplaintRepository complaintRepository, UserRepository userRepository, AddressRepository addressRepository) {
        this.complaintRepository = complaintRepository;
        this.userRepository = userRepository;
        this.addressRepository = addressRepository;
    }

    @GetMapping
    public Page<Complaint> getComplaints(@PageableDefault(size = 50) Pageable pageable) {
        return complaintRepository.findAll(pageable);
    }

    @GetMapping("/{id}")
    public Complaint getComplaint(@PathVariable Long id) {
        return complaintRepository.findById(id)
                .orElseThrow(() -> new ComplaintNotFoundException(id));
    }

    @PostMapping
    public Complaint newComplaint(@RequestBody Complaint complaint, @RequestParam MultipartFile multipartImage) throws Exception {
        complaint.setId(0L);

        User user = userRepository.findById(complaint.getUser().getId())
                .orElseThrow(() -> new UserNotFoundException(complaint.getUser().getId()));
        complaint.setUser(user);

        Address address = addressRepository.findById(complaint.getAddress().getId())
                .orElseThrow(() -> new AddressNotFoundException(complaint.getAddress().getId()));
        complaint.setAddress(address);

        complaint.setImage(multipartImage.getBytes());

        return complaintRepository.save(complaint);
    }

    @PutMapping("/{id}")
    public Complaint updateComplaint(@PathVariable Long id, @RequestBody Complaint newComplaint) {
        return complaintRepository.findById(id)
                .map(complaint -> {
                    complaint.setDatetime(newComplaint.getDatetime());
                    complaint.setText(newComplaint.getText());
                    complaint.setImage(newComplaint.getImage());
                    complaint.setUser(userRepository.findById(newComplaint.getUser().getId())
                            .orElseThrow(() -> new UserNotFoundException(newComplaint.getUser().getId())));
                    complaint.setAddress(addressRepository.findById(newComplaint.getAddress().getId())
                            .orElseThrow(() -> new AddressNotFoundException(newComplaint.getAddress().getId())));
                    return complaintRepository.save(complaint);
                })
                .orElseThrow(() -> new ComplaintNotFoundException(id));
    }

    @DeleteMapping("/{id}")
    public void deleteComplaint(@PathVariable Long id) {
        complaintRepository.deleteById(id);
    }
}
