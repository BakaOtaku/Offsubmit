import React, { useEffect, useState } from 'react'
import Web3 from 'web3';
import Portis from '@portis/web3';
import { CourseCreatorAbi, CourseCreatorAddress, CourseAbi } from '../config';
import axios from 'axios';
import Loader from './Loader'
import { toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
toast.configure();

function Teacher() {
    const [account, setAccount] = useState('');
    const [loading, setLoading] = useState(false);
    const [file, setFile] = useState('');
    const [link, setLink] = useState('');
    const [studentId, setStudentId] = useState('');
    const [show, setShow] = useState(null);
    const [deadline, setDeadline] = useState(null);
    const [courseAddress, setCourseAddress] = useState('');

    useEffect(() => {
        const loadBlockchaindata = async () => {
            setLoading(true);
            const portis = new Portis('148b0f9b-ca4d-4998-bf3c-7707b7b93c0a', 'maticMumbai');
            // const web3 = new Web3(Web3.givenProvider);
            const web3 = new Web3(portis.provider)
            await web3.eth.net.getNetworkType();
            const accounts = await web3.eth.getAccounts();
            if (accounts) {
                setAccount(accounts[0]);
                console.log(account);
                setLoading(false);
            } else {
                window.alert("No web3? You should consider trying MetaMask!")
            }
        }
        loadBlockchaindata();
    }, [account])

    const handleCreateCource = async (e) => {
        e.preventDefault();
        console.log('Submiting data');
        setLoading(true);

        // 1.  Give file to backend for encryption
        const formData = new FormData();
        formData.append('file', file);
        console.log(file);

        const res = await axios.post('https://tokensprtify.herokuapp.com/encrypt', formData);
        toast("File Encrypted", { type: "success" });
        let str = res.data;
        str = str.split(" ");
        const [privateKey, fh] = str;
        console.log(privateKey, fh);

        // 2.  Create course functionality for a new registered course
        const portis = new Portis('148b0f9b-ca4d-4998-bf3c-7707b7b93c0a', 'maticMumbai');
        const web3 = new Web3(portis.provider);
        await web3.eth.net.getNetworkType();

        const courseCreator = new web3.eth.Contract(CourseCreatorAbi, CourseCreatorAddress);
        await courseCreator.methods.createCourse(deadline).send({ from: account });
        toast("Course Created", { type: "success" });

        // fetch course deployed address for login part
        let t;
        await courseCreator.methods.fetchCourseAddress().call({ from: account },
            (error, result) => {
                console.log(`Course ${result}`);
                t = result;
            });


        setCourseAddress(t);
        // setShow(`Private Key: ${privateKey} \n File link: https://ipfs.io/ipfs/${fh} \n Course Address: ${courseAddress}`);
        setShow({
            pkey: privateKey,
            file_link: `https://ipfs.io/ipfs/${fh}`,
            cs: t
        })
        console.log(show);
        setLoading(false);
    }

    const handleGetAnswer = async (e) => {
        e.preventDefault();

        let hash;
        const portis = new Portis('148b0f9b-ca4d-4998-bf3c-7707b7b93c0a', 'maticMumbai');
        const web3 = new Web3(portis.provider);
        const courseCreator = new web3.eth.Contract(CourseCreatorAbi, CourseCreatorAddress);
        let t;
        await courseCreator.methods.fetchCourseAddress().call({ from: account },
            (error, result) => {
                console.log(`Course ${result}`);
                t=result;
            });

        const course = new web3.eth.Contract(CourseAbi, t);
        console.log(t);
        await course.methods.fileHash(studentId).call({ from: account }, (error, result) => {
            console.log(`fileHash ${result}`);
            hash = result;
        });
        console.log(hash);

        const x = await axios({
            url: link,
            method: 'GET',
            responseType: 'blob',
        })
        const file2 = new Blob([x.data]);
        const formData = new FormData();
        formData.append('file', file2);
        formData.append('comparisonHash', hash);
        const res = await axios.post(`https://tokensprtify.herokuapp.com/fileHashMatch`, formData, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        });
        console.log(res.data);
        if (res.data === 'verified') {
            toast("Verified, Download starts", { type: "success" });
            const url = window.URL.createObjectURL(new Blob([x.data]));
            const ll = document.createElement('a');
            ll.href = url;
            ll.setAttribute('download', 'file.pdf');
            document.body.appendChild(ll);
            ll.click();
        } else {
            toast("File Hash Not matched", { type: "error" });
        }
    }

    const handleFileUpload = async (e) => {
        e.preventDefault();
        setFile(e.target.files[0]);
    }
    const handleDeadline = (e) => {
        e.preventDefault();
        setDeadline(Date.parse(e.target.value));
        console.log(deadline);
    }
    const handlelink = (e) => {
        e.preventDefault();
        setLink(e.target.value);
    }
    const handlestudentId = (e) => {
        e.preventDefault();
        setStudentId(e.target.value);
    }

    function IfShow() {
        return (
            <div>
                <h3 className="text-light">Course Created Please message these</h3>
                <span>File Password: {show.pkey}</span>
                <br />
                <span>File link: {show.file_link}</span>
                <br />
                <span>Subject Id: {show.cs}</span>
            </div >
        )
    }

    return (
        <div>
            <svg id="wavy-header" viewBox="0 0 761 117" fill="none" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M224.211 115.669C47.737 120.607 0 76 0 76V0h761v92c-112.975-8.266-183.614-38.828-386.942 2.247-51.942 10.493-77.912 15.739-99.206 18.17-21.294 2.43-31.076 2.704-50.641 3.252z" fill="#23374d" /></svg>
                <a href="/"><div className="topleft"> 💫 Off Submit ✨</div></a>
            <div className="container">
                <h1 className="text-box">
                    <span style={{ fontWeight: '400' }}>Teacher's Application</span>
                </h1>
            </div>
            {loading ? <Loader /> : <></>}

            <div className="sec-container">
                <div className="sec">
                    {show ? <IfShow /> :
                        <>
                            <div className="info-title">Create New Course</div>
                            <br />
                            <form className="form-wrapper" onSubmit={handleCreateCource}>
                                <h3 className="text-light">Upload Question paper</h3>
                                <input
                                    className="custom-file-input"
                                    type="file"
                                    id="file"
                                    onChange={handleFileUpload}
                                />
                                <h3 className="text-light">Choose Exam End time</h3>
                                <input
                                    className="exam-date"
                                    type="datetime-local"
                                    id="birthdaytime"
                                    name="birthdaytime"
                                    onChange={handleDeadline}
                                />
                                <button className="create-course" type="submit">Create</button>
                            </form>
                        </>
                    }
                </div>
                <div className="sec">
                    <div className="sec">
                        <div className="info-title">Get students solution sheet</div>
                        <br />
                        <form className="form-wrapper" onSubmit={handleGetAnswer}>
                            <h3 className="text-light">Enter File link</h3>
                            <input
                                className="custom-file-input"
                                onChange={handlelink}
                            />
                            <h3 className="text-light">Enter Student Id</h3>
                            <input
                                className="custom-file-input"
                                onChange={handlestudentId}
                            />
                            <button className="create-course" type="submit">Get Answer</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    )
}


export default Teacher;