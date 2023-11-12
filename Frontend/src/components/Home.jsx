import React, { useState, useEffect } from "react";
import Nav from "./Nav";
import Comments from "../utils/Comments";
import { create } from 'ipfs-http-client'
import { AleoWorker } from "../workers/AleoWorker.js";
import { splitStringToBigInts, joinBigIntsToString } from "../utils/bigintString.js";
import trueblind_main_program from "../../../programs/trueblind_main/build/main.aleo?raw";

const Home = () => {
    const projectId = "2Y3P4fHevOjxYIoleyUr3mS86qZ";
    const projectSecretKey = "0edcafbacf80fd6608c4014f0d26a1c2";
    const authorization = "Basic " + btoa(projectId + ":" + projectSecretKey);
    const aleoWorker = AleoWorker();
    const client = create({
        host: 'ipfs.infura.io',
        port: 5001,
        protocol: 'https',
        headers: {
            authorization: authorization,
        }
      })

    const [account, setAccount] = useState(null);
    const [thread, setThread] = useState("");
    const [threadDescription, setThreadDescription] = useState("");
    const [threadList, setThreadList] = useState([]);
    const [privateKey, setPrivateKey] = useState([]);
    const [record, setRecord] = useState([]);
    const [passRecord, setPassRecord] = useState([]);
    const [executing, setExecuting] = useState(false);
    
    useEffect(() => {
        
        const fetchAllThreads = async () => {
            let temp_threadList = [];
            //TODO Fetch all Categories
            let Categories = ["Korean", "Chinese"] 
            //TODO Fetch all CIDs
            let CIDs = ["QmZFDewS8exT85zGonYQCuwujJDhTKShLHbXrazaTVsCdD", "QmRk8KaEWR4trD6B56ag2r1paTL989fCJefkJB1mnemzfm", "QmQ6hKXo6XPzN7a43R175ANsoQqp7XsUT7VXVrXbto7BVS", "QmbYLjEjTh1serYJ9uEqgVjK1oLfWJ2NT7ifPY7LnpMxRf"]
            let i = 0;
            while (i < CIDs.length) {
                await fetch("https://ipfs.io/ipfs/" + CIDs[i])
                    .then((response) => response.json())
                    .then((json) => {
                        console.log(json);
                        console.log(i, Categories[i]);
                        temp_threadList.push({
                            title: json.title,
                            description: json.description,
                            category: Categories[i],
                            CID: CIDs[i],
                        });
                    });
                i++;
            }
            console.log(temp_threadList);
            setThreadList(temp_threadList);
            
        };
        fetchAllThreads();
    }, []);

    const handleSubmit = async (e) => {
        e.preventDefault();
        console.log({ thread });
        console.log({ threadDescription });
        let someObject = {
            title: thread,
            description: threadDescription
        };
        let objectString = JSON.stringify(someObject);
        try {
            const added = await client.add(objectString);
            const threadCID = added.path;
            console.log(threadCID);
            let cid_splits = splitStringToBigInts(threadCID);
            console.log("cidsplits", cid_splits, cid_splits.length);
            setExecuting(true);
            let cid_json = "{cid1: " + cid_splits[0] + ", cid2: " + cid_splits[1] + ", cid3: " + cid_splits[2] + "}";
            console.log("before create post",[cid_json, passRecord]);
            const result = await aleoWorker.localProgramExecution(
                trueblind_main_program,
                "create_post",
                [cid_json, passRecord],
            );
            alert(JSON.stringify(result));
            setExecuting(false);
          } catch (error) {
            console.log('Error uploading file: ', error)
          } 
        // setThread("");
        // setThreadDescription("");
    };

    const handleLogin = async (e) => {
        e.preventDefault();
        console.log({ privateKey });
        setAccount(privateKey);
        setPassRecord(record);
        alert("User signed in!");
    };

    return (
        <>
            <Nav />
            <main className='home'>
                <h2 className='homeTitle'>Create a Thread</h2>
                <form className='homeForm' onSubmit={handleLogin}>
                    <div className='home__container'>
                        <label htmlFor='thread'>Private Key</label>
                        <input
                            type='text'
                            name='thread'
                            required
                            value={privateKey}
                            onChange={(e) => setPrivateKey(e.target.value)}
                        />
                        <label htmlFor='thread'>Pass Record</label>
                        <input
                            type='text'
                            name='thread'
                            required
                            value={record}
                            onChange={(e) => setRecord(e.target.value)}
                        />
                    </div>
                    <button className='homeBtn'>Login</button>
                </form>
                <form className='homeForm' onSubmit={handleSubmit}>
                    <div className='home__container'>
                        <label htmlFor='thread'>Title</label>
                        <input
                            type='text'
                            name='thread'
                            required
                            value={thread}
                            onChange={(e) => setThread(e.target.value)}
                        />
                        <label htmlFor='threadDescription'>Description</label>
                        <input
                            type='text'
                            name='threadDescription'
                            required
                            value={threadDescription}
                            onChange={(e) => setThreadDescription(e.target.value)}
                        />
                    </div>
                    <button className='homeBtn'>CREATE THREAD</button>
                </form>

                <div className='thread__container'>
                    {threadList.map((thread) => (
                        <div className='thread__item' key={thread.CID}>
                            <p>{thread.title}</p>
                            {/* <p>{thread.description}</p> */}
                            <div className='react__container'>
                                <p style={{ opacity: "0.5" }}>by {thread.category}</p>
                                <Comments
                                    threadId={thread.CID}
                                    threadCategory={thread.category}
                                    // title={thread.title}
                                />
                            </div>
                        </div>
                    ))}
                </div>
            </main>
        </>
    );
};

export default Home;