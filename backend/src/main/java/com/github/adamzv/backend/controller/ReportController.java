package com.github.adamzv.backend.controller;

import com.github.adamzv.backend.exception.ReportNotFoundException;
import com.github.adamzv.backend.exception.UserNotFoundException;
import com.github.adamzv.backend.model.Report;
import com.github.adamzv.backend.model.User;
import com.github.adamzv.backend.repository.ReportRepository;
import com.github.adamzv.backend.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
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
    public Page<Report> getReports(@PageableDefault(size = 50) Pageable pageable) {
        return reportRepository.findAll(pageable);
    }

    @GetMapping("/id")
    public Report getReport(@PathVariable Long id) {
        return reportRepository.findById(id)
                .orElseThrow(() -> new ReportNotFoundException(id));
    }

    @PostMapping
    public Report newReport(@RequestBody Report report) {
        report.setId(0L);

        User user = userRepository.findById(report.getUser().getId())
                .orElseThrow(() -> new UserNotFoundException(report.getUser().getId()));
        report.setUser(user);
        return reportRepository.save(report);
    }

    @PutMapping("/{id}")
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
    public void deleteReport(@PathVariable Long id) {
        reportRepository.deleteById(id);
    }
}
