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
        assert_eq(self.caller, aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw);
        return Pass {
            owner: requester,
            nationality: nationality,
        };
    }
}
