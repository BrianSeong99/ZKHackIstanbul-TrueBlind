// The 'trueblind_issuer' program.
program trueblind_issuer.aleo {
    
    // Issue pass based on nationality
    // 1 - United State
    // 2 - Malaysia
    // 3 - Turkey
    record Pass {
        owner: address,
        nationality: u8,
    }

    transition issue_pass(requester: address, nationality: u8) -> Pass {
        assert_eq(self.caller, aleo158m35rhjzjaejtxhgkrrlu222qlzs706fnkgzlxuyua2wf94qgzs8twkv5);
        return Pass {
            owner: requester,
            nationality: nationality,
        };
    }
}
