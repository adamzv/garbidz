package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.ReportNotFoundException;
import com.github.adamzv.backend.exception.UserNotFoundException;
import com.github.adamzv.backend.model.Complaint;
import com.github.adamzv.backend.model.Report;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.repository.ReportRepository;
import com.github.adamzv.backend.repository.UserRepository;
import com.github.adamzv.backend.security.annotation.IsModerator;
import com.github.adamzv.backend.security.annotation.IsSpecificUserOrModerator;
import com.github.adamzv.backend.security.annotation.IsUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/reports")
public class ReportController {

    private ReportRepository reportRepository;
    private UserRepository userRepository;

    public ReportController(ReportRepository reportRepository, UserRepository userRepository) {
        this.reportRepository = reportRepository;
        this.userRepository = userRepository;
    }

    @GetMapping
    @IsModerator
    public Page<Report> getReports(@PageableDefault(size = 50) Pageable pageable) {
        return reportRepository.findAll(pageable);
    }

    @GetMapping("/user/{id}")
    @IsUser
    @IsSpecificUserOrModerator
    public ResponseEntity<Page<Report>> getUsersComplaints(Pageable pageable, @PathVariable Long id) {
        return ResponseEntity.ok(reportRepository.findAllByUser_Id(pageable, id));
    }

    @GetMapping("/id")
    @IsUser
    @IsSpecificUserOrModerator
    public Report getReport(@PathVariable Long id) {
        return reportRepository.findById(id)
                .orElseThrow(() -> new ReportNotFoundException(id));
    }

    @PostMapping
    @IsModerator
    public Report newReport(@RequestBody Report report) {
        report.setId(0L);

        User user = userRepository.findById(report.getUser().getId())
                .orElseThrow(() -> new UserNotFoundException(report.getUser().getId()));
        report.setUser(user);
        return reportRepository.save(report);
    }

    @PutMapping("/{id}")
    @IsModerator
    public Report updateReport(@PathVariable Long id, @RequestBody Report newReport) {
        return reportRepository.findById(id)
                .map(report -> {
                    report.setMessage(newReport.getMessage());
                    report.setDatetime(newReport.getDatetime());
                    report.setUser(userRepository.findById(newReport.getUser().getId())
                            .orElseThrow(() -> new UserNotFoundException(newReport.getUser().getId())));
                    return reportRepository.save(report);
                })
                .orElseThrow(() -> new ReportNotFoundException(id));
    }

    @DeleteMapping("/{id}")
    @IsModerator
    public void deleteReport(@PathVariable Long id) {
        reportRepository.deleteById(id);
    }
}
