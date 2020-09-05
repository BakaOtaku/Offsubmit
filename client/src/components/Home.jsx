import React, { Component } from 'react'

class Home extends Component {
    render() {
        return (
            <>
                <svg id="wavy-header" viewBox="0 0 761 117" fill="none" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M224.211 115.669C47.737 120.607 0 76 0 76V0h761v92c-112.975-8.266-183.614-38.828-386.942 2.247-51.942 10.493-77.912 15.739-99.206 18.17-21.294 2.43-31.076 2.704-50.641 3.252z" fill="#23374d" /></svg>
                <div className="topleft"> Aman UX vala ✨   </div>
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
                                src="https://images.unsplash.com/photo-1554072675-66db59dba46f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1053&q=80"
                                alt="android-app"
                            />
                            <div class="information">
                                <div class="info-title">For Students</div>
                                <br />
                                <div class="info-all">
                                    Here Students come and add answers and all things haha
                                </div>
                                <button>Open App</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="page1">
                    <div class="container">
                        <div class="page1-box">
                            <img
                                class="page1-img"
                                src="https://images.unsplash.com/photo-1554072675-66db59dba46f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1053&q=80"
                                alt="android-app"
                            />
                            <div class="information">
                                <div class="info-title">For Teachers</div>
                                <br />
                                <div class="info-all">
                                    Here Teachers come and add questions and all things haha
                                </div>
                                <a href="/teachers"><button>Open Portal</button></a>
                            </div>
                        </div>
                    </div>
                </div>

            </>
        )
    }
}

export default Home;