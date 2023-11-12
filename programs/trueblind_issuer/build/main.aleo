program trueblind_issuer.aleo;

record Pass:
    owner as address.private;
    name as u128.private;
    age as u8.private;
    nationality as u8.private;


function issue_pass:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as u8.private;
    input r3 as u8.private;
    assert.eq self.caller aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw;
    cast r0 r1 r2 r3 into r4 as Pass.record;
    output r4 as Pass.record;
