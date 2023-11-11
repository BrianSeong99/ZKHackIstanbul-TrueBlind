import trueblind_issuer.aleo;
program trueblind_main1.aleo;


struct Content:
    cid as u128;
    nationality as u8;


mapping head:
	key as u8.public;
	value as u128.public;


mapping post:
	key as u128.public;
	value as Content.public;


mapping comments:
	key as u128.public;
	value as Content.public;

function create_post:
    input r0 as u128.private;
    input r1 as trueblind_issuer.aleo/Pass.record;
    async create_post r0 r1.nationality into r2;
    output r1 as trueblind_issuer.aleo/Pass.record;
    output r2 as trueblind_main1.aleo/create_post.future;

finalize create_post:
    input r0 as u128.public;
    input r1 as u8.public;
    get.or_use head[0u8] 0u128 into r2;
    cast r0 r1 into r3 as Content;
    set r3 into post[r2];
    add r2 1u128 into r4;
    set r4 into head[0u8];
