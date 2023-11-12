program trueblind_issuer.aleo;

record Pass:
    owner as address.private;
    nationality as u8.private;


function issue_pass:
    input r0 as address.private;
    input r1 as u8.private;
    assert.eq self.caller aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw;
    cast r0 r1 into r2 as Pass.record;
    output r2 as Pass.record;
