import trueblind_issuer.aleo;
program trueblind_main.aleo;


struct Cid:
    cid1 as u128;
    cid2 as u128;

struct Post:
    cid as Cid;
    nationality as u8;

struct Comment:
    cid as Cid;
    nationality as u8;


mapping head:
	key as u8.public;
	value as u128.public;


mapping post:
	key as u128.public;
	value as Post.public;


mapping comments:
	key as field.public;
	value as Comment.public;

function create_post:
    input r0 as Cid.private;
    input r1 as trueblind_issuer.aleo/Pass.record;
    async create_post r0 r1.nationality into r2;
    output r1 as trueblind_issuer.aleo/Pass.record;
    output r2 as trueblind_main.aleo/create_post.future;

finalize create_post:
    input r0 as Cid.public;
    input r1 as u8.public;
    get.or_use head[0u8] 0u128 into r2;
    cast r0 r1 into r3 as Post;
    set r3 into post[r2];
    add r2 1u128 into r4;
    set r4 into head[0u8];


function make_comment:
    input r0 as Cid.private;
    input r1 as Cid.private;
    input r2 as trueblind_issuer.aleo/Pass.record;
    hash.psd2 r0 into r3 as field;
    async make_comment r3 r1 r2.nationality into r4;
    output r2 as trueblind_issuer.aleo/Pass.record;
    output r4 as trueblind_main.aleo/make_comment.future;

finalize make_comment:
    input r0 as field.public;
    input r1 as Cid.public;
    input r2 as u8.public;
    cast r1 r2 into r3 as Comment;
    set r3 into comments[r0];


function hash_cid:
    input r0 as Cid.private;
    hash.psd2 r0 into r1 as field;
    output r1 as field.private;
