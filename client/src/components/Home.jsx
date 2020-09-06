import React, { Component } from 'react'

class Home extends Component {
    render() {
        return (
            <>
                <svg id="wavy-header" viewBox="0 0 761 117" fill="none" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M224.211 115.669C47.737 120.607 0 76 0 76V0h761v92c-112.975-8.266-183.614-38.828-386.942 2.247-51.942 10.493-77.912 15.739-99.206 18.17-21.294 2.43-31.076 2.704-50.641 3.252z" fill="#23374d" /></svg>
                <a href="/"><div className="topleft"> 💫 Off Submit ✨</div></a>
                <div className="container">
                    <h1 className="text-box">
                        <span style={{ fontWeight: '400' }}>First online </span>
                        <span className="underline" > examination tool </span>
                        <p>which works offline.</p>
                    </h1>
                </div>

                <div class="page1">
                    <div class="container">
                        <div class="page1-box">
                            <img
                                class="page1-img"
                                src="https://image.flaticon.com/icons/svg/2416/2416611.svg"
                                alt="android-app"
                            />
                            <div class="information">
                                <div class="info-title">For Students</div>
                                <br />
                                <div class="info-all">
                                    Student's side Android and ios application where students will have to download the AES encrypted question papers of all exams collectively before 10-15days of exams.
                                    And can attemp paper on the date with SMS OTP key without internet. 
                                </div>
                                <a href="https://github.com/BakaOtaku/Offsubmit/releases/"><button className="create-course">Get App</button></a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="page1">
                    <div class="container">
                        <div class="page1-box">
                            <img
                                class="page1-img"
                                src="https://image.flaticon.com/icons/svg/2333/2333027.svg"
                                alt="android-app"
                            />
                            <div class="information">
                                <div class="info-title">For Teachers</div>
                                <br />
                                <div class="info-all">
                                    Teacher's side web application where teacher can create test, get studnets answer sheet. Now the professor's can download the answer sheets and do the evaluation. 
                                    
                                </div>
                                <a href="/teachers"><button className="create-course">Open Portal</button></a>
                            </div>
                        </div>
                    </div>
                </div>

            </>
        )
    }
}

export default Home;
