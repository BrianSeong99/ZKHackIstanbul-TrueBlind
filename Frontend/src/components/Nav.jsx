import React from "react";
import { WalletMultiButton } from '@demox-labs/aleo-wallet-adapter-reactui/';

const Nav = () => {
    // const signOut = () => {
    //     alert("User signed out!");
    // };
    return (
        <nav className='navbar'>
            <h2>TrueBlind</h2>
            <div className='navbarRight'>
                {/* <button onClick={signOut}>Sign out</button> */}
                <WalletMultiButton />
            </div>
        </nav>
    );
};

export default Nav;