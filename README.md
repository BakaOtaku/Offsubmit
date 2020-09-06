<p align="center"><img src="https://user-images.githubusercontent.com/42104907/92314962-af4bd100-effc-11ea-91cf-9fac2e3e8648.png" align="center" width="400"></p>
<a href=""><h1 align="center">Off Submit</h1></a>
<h4 align="center">Making online exams happen offline</h4>

## Live Links

[Web Platform](https://offsubmit.vercel.app/)

[Mobile App](https://github.com/BakaOtaku/Offsubmit/releases/)

[Presentation](./Presentation.pdf)

## The problem:

- Due to COVID, many institutes decided to conduct remote online open-book exams.
- Internet speed in many parts of India is insufficient for downloading the question papers and submitting answer sheets in a quick time.
- Students of Jammu & Kashmir also face a lot of problems due to no 4G services.
- This caused a lot of students inconvenience and even to opt-out of the remote exams.

## How it solves:

10 to 15 days before the exam, students will have to download the AES encrypted question papers of all exams collectively. Since now the student has sufficient time so there are no worries of slow internet speed.

Just before the beginning of each exam, the teacher will SMS the password to unlock that question paper and the app will decrypt the question paper so that students can now see it and start with the exam.

After writing the answer sheet, the student will create a pdf and the app will then create an SHA-256 hash of it and this hash will be sent as SMS from the student’s phone to Twilio no. and if the student has sent the SMS before the deadline of the exam, say 1 hour later, then this hash will be stored on the Ethereum-Matic chain corresponding to his id.

Now the previous process will be repeated for the remaining of the exams.

Once all the exams are over then the student can upload his answer sheets pdf taking an ample amount of time so that there is no inconvenience for slow internet speed users.

Now the app will check whether the student has uploaded the same answer sheets by matching the uploaded file’s hash and previously SMS hash stored on the Matic blockchain.

This will check that student has not tampered with the file after the deadline of the exam.

Now the professor can download the answer sheets and do the evaluation.

## Unique Selling Points

- The app can be scaled to an offline Moodle app for exam .
- The app does not use System time to keep track of submission as System time can be changed.
- The app leverages Proof of Existence protocol of Blockchain to ensure the scrutiny of submitted answer sheets.
- The app is Ethereum based which allots a wallet id to students to ensure their easy on boarding.
- Students are not restricted to use a particular mobile no. for submission.
- They have to just send the generated SMS.
- The professor just requires a Portis wallet with some Matic Ether and he can be easily onboarded.

## Tech Stack

<details>
	<summary>Blockchain</summary>
		<ul>
			<li>Ethereum + Matic</li>
			<li>Portis</li>
		  <li>Solidity</li>
		</ul>
</details>

<details>
	<summary>Backend</summary>
		<ul>
			<li>Spring Boot - Java</li>
			<li>Twilio SMS API</li>
		  <li>Web3j</li>
		</ul>
</details>

<details>
	<summary>Frontend</summary>
		<ul>
			<li>React</li>
			<li>Web3.js</li>
		  <li>Portis</li>
		</ul>
</details>

<details>
	<summary>Mobile App</summary>
		<ul>
			<li>Flutter</li>
			<li>Crypto</li>
		</ul>
</details>

## Team

- [ 👨🏻‍💻 Ashutosh Singh](https://github.com/thecodepapaya)
- [ 👨🏻‍🎓 Arpit Srivastava](https://github.com/fuzious)
- [ 🌊 Aman Raj](https://github.com/AmanRaj1608)

<p align="center"> Made with ❤️ and 💻</p>
