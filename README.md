# DockerAngular

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 15.2.11.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Deploying to Firebase with Jenkins

When you push to GitHub, Jenkins runs the pipeline: **Checkout → Install → Test → Build → Deploy to Firebase Hosting**.

### One-time setup

1. **Firebase project**
   - Create a project in [Firebase Console](https://console.firebase.google.com).
   - Replace `YOUR_FIREBASE_PROJECT_ID` in `.firebaserc` with your project ID.

2. **Firebase CI token**
   - Locally: `npx firebase-tools login:ci`
   - Copy the generated token.

3. **Jenkins**
   - **Jenkins → Manage Jenkins → Credentials**: add a **Secret text** credential with the Firebase token.
   - Set the credential ID to `firebase-deploy-token` (or change that ID in the Jenkinsfile).
   - Configure the job to build on **GitHub push** (e.g. webhook or poll SCM).

After that, each push runs the pipeline and deploys the built app to Firebase Hosting.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI Overview and Command Reference](https://angular.io/cli) page.
