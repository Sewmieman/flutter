// These are the Angular functions we need. signal() and computed() come from Angular's core.
import { rxResource } from "@angular/core/rxjs-interop";
import { Component, signal, computed, inject } from "@angular/core";
import { CourseCardComponent } from "../../ui/course-card/course-card.component";
import { Course } from "../../models/course.model";
import { CourseService } from "../../services/course.service";

// The @Component decorator tells Angular: "This class is a visual component."
// It is metadata it describes how this class connects to the HTML temlate.
@Component({
    selector: 'app-student-dashboard',
    standalone: true,
    imports: [CourseCardComponent], // This tells Angular: "I use CourseCardComponent in my template"
    templateUrl: './student-dashboard.component.html',
    styleUrl: './student-dashboard.component.scss'
})
export class StudentDashboardComponent {
    selectedCourse: any;
    // signal('Liya Kebede') creates a reactive variable. Angular watches it.
    // When its value changes, Angular automatically updates the part of the screen that displays it.
    // studentName = signal("Liya Kebede");
    // earnedCredits = signal(45);
    // // signal<Course | null>(null) means: "This signal holds either a Course or nothing."
    // // The | null syntax is TypeScript's way of saying a value can be absent.
    // selectedCourse = signal<Course | null>(null);
    // // A sample course to display (we will switch to an array in Excercise3)
    // sampleCourse: Course = {
    //     id: 1,
    //     title: "Advanced Java Services",
    //     code: "CSE-101",
    //     maxCapacity: 30,
    //     enrollmentCount: 12,
    // };
    handleEnroll(course: Course) {
        this.selectedCourse.set(course);
        console.log('Enrollment requested for:', course.title);
    }
    // // computed() creates a read-only signal that derives its value from other signals.
    // // It recalculates automatically whenever earnedCredits() changes no manual refresh.
    // graduationStatus = computed(() =>
    //     this.earnedCredits() >= 120 ? "Eligible for Graduation" : "In Progress",);
    // // A regular method. When called, it updates the earnedCredits signal.
    // // The .update() method receives the current value (c) and returns the new value (c + 3).
    // registerForClass() {
    //     this.earnedCredits.update((c) => c + 3);

    // }

// Angular finds the singleton instance and gives it to us.
private api = inject(CourseService);
studentName = signal("Liya Kebede");
earnedCredits = signal(45);
graduationStatus = computed(() =>
this.earnedCredits() >= 120 ? "Eligible for Graduation" : "In Progress",);
// rxResource wraps the HTTP call into three managed signals:
// - coursesResource.isLoading() → true while waiting for the server response
// - coursesResource.error() → the error object if the requestfails
// - coursesResource.value() → the Course[] array when the request succeeds
//
// It handles subscribing (starting the request) and unsubscribing (cleaning up
// if the user navigates away before the response arrives) automatically.
// You never write .subscribe() or .unsubscribe() with rxResource.
coursesResource = rxResource({
stream: () => this.api.getAll(),
});
}
