program trueblind_issuer.aleo;

record Pass:
    owner as address.private;
    nationality as u8.private;


function issue_pass:
    input r0 as address.private;
    input r1 as u8.private;
    assert.eq self.caller aleo158m35rhjzjaejtxhgkrrlu222qlzs706fnkgzlxuyua2wf94qgzs8twkv5;
    cast r0 r1 into r2 as Pass.record;
    output r2 as Pass.record;
