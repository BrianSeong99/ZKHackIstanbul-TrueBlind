import React, { useState, useEffect } from "react";
import Nav from "./Nav";
import Comments from "../utils/Comments";
import { create } from 'ipfs-http-client'

const Home = () => {
    const projectId = "2Y3P4fHevOjxYIoleyUr3mS86qZ";
    const projectSecretKey = "0edcafbacf80fd6608c4014f0d26a1c2";
    const authorization = "Basic " + btoa(projectId + ":" + projectSecretKey);

    const client = create({
        host: 'ipfs.infura.io',
        port: 5001,
        protocol: 'https',
        headers: {
            authorization: authorization,
        }
      })

    const [thread, setThread] = useState("");
    const [threadDescription, setThreadDescription] = useState("");
    const [threadList, setThreadList] = useState([]);
    
    useEffect(() => {
        
        const fetchAllThreads = async () => {
            let temp_threadList = [];
            //TODO Fetch all Categories
            let Categories = ["Korean", "Chinese"] 
            //TODO Fetch all CIDs
            let CIDs = ["QmZFDewS8exT85zGonYQCuwujJDhTKShLHbXrazaTVsCdD", "QmRk8KaEWR4trD6B56ag2r1paTL989fCJefkJB1mnemzfm", "QmQ6hKXo6XPzN7a43R175ANsoQqp7XsUT7VXVrXbto7BVS"]
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
            // TODO: Call Create Post on Leo with CID and zPass
          } catch (error) {
            console.log('Error uploading file: ', error)
          } 
        setThread("");
        setThreadDescription("");
    };

    return (
        <>
            <Nav />
            <main className='home'>
                <h2 className='homeTitle'>Create a Thread</h2>
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