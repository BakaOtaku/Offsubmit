import React, { useEffect, useState } from 'react'

function Teacher() {
    const [account, setAccount] = useState('');

    return (
        <div>
            <svg id="wavy-header" viewBox="0 0 761 117" fill="none" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M224.211 115.669C47.737 120.607 0 76 0 76V0h761v92c-112.975-8.266-183.614-38.828-386.942 2.247-51.942 10.493-77.912 15.739-99.206 18.17-21.294 2.43-31.076 2.704-50.641 3.252z" fill="#23374d" /></svg>
            <div className="topleft"> Aman UX vala ✨</div>
        </div>
    )
}



export default Teacher;
