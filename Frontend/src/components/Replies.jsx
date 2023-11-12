import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { create } from 'ipfs-http-client'

const Replies = () => {
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

    const [replyList, setReplyList] = useState([
        {
            "text": "I think so",
            "category": "Korean",
            "cid": "QmZFDewS8exT85zGonYQCuwujJDhTKShLHbXrazaTVsCdD",
        },
    ]);
    const [reply, setReply] = useState("");
    const { CID, category } = useParams();
    const [thread, setThread] = useState("");
    const [threadDescription, setThreadDescription] = useState("");

    useEffect(() => {

        const fetchThread = async () => {
            let temp_tread = "";
            let temp_treadDescription = "";
            await fetch("https://ipfs.io/ipfs/" + CID)
                    .then((response) => response.json())
                    .then((json) => {
                        console.log(json);
                        temp_tread = json.title;
                        temp_treadDescription = json.description;
                    });
            setThread(temp_tread);
            setThreadDescription(temp_treadDescription);
            
        };

        const fetchReplies = async () => {
            let temp_replyList = [];
            // TODO Fetch All Replies CIDs from the thread CID
            let Categories = ["South Korea", "China"]
            //TODO Fetch all CIDs
            let CIDs = ["QmZh1qNG6h6qDJfzvCWoe9iXmnwwbeATwN46o6gKvue5yU", "QmRL66E8CybUpHbqaxGWBLFHbMRQvixYeNqGgt9w7srsgH"]
            let i = 0;
            while (i < CIDs.length) {
                await fetch("https://ipfs.io/ipfs/" + CIDs[i])
                    .then((response) => response.json())
                    .then((json) => {
                        console.log(json);
                        console.log(i, Categories[i]);
                        temp_replyList.push({
                            text: json.text,
                            category: Categories[i],
                            CID: CIDs[i],
                        });
                    });
                i++;
            }
            console.log(temp_replyList);
            setReplyList(temp_replyList);
        };
        fetchThread();
        fetchReplies();
    }, [CID]);

    const addReply = async () => {
        let someObject = {
            text: reply,
        };
        let objectString = JSON.stringify(someObject);
        try {
            const added = await client.add(objectString);
            const replyCID = added.path;
            console.log(replyCID);
            // TODO: Call Create Reply on Leo with CID and zPass
          } catch (error) {
            console.log('Error uploading file: ', error)
          } 
          setReply("");
    };
    
    const handleSubmitReply = (e) => {
        e.preventDefault();
        //👇🏻 calls the function
        addReply();
        setReply("");
    };

    return (
        <main className='replies'>
            <h1 className='repliesTitle'>{thread}</h1>
            <p style={{ opacity: "0.5" }}>by {category}</p>
            <br/>
            <p style={{ opacity: "0.8" }}>{threadDescription}</p>
    
            <form className='modal__content' onSubmit={handleSubmitReply}>
                <label htmlFor='reply'>Reply to the thread</label>
                <textarea
                    rows={5}
                    value={reply}
                    onChange={(e) => setReply(e.target.value)}
                    type='text'
                    name='reply'
                    className='modalInput'
                />
    
                <button className='modalBtn'>SEND</button>
            </form>
            <div className='thread__container'>
                {replyList.map((reply) => (
                    <div className='thread__item'>
                        <p>{reply.text}</p>
                        <div className='react__container'>
                            <p style={{ opacity: "0.5" }}>by {reply.category}</p>
                        </div>
                    </div>
                ))}
            </div>
        </main>
    );
};

export default Replies;