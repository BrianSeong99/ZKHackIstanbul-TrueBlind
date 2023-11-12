// The 'trueblind_main' program.
import trueblind_issuer.leo;

program trueblind_main.aleo {

    struct Cid {
        cid1: u128,
        cid2: u128,
    }

    struct Post {
        cid: Cid,
        nationality: u8,
    }

    struct Comment {
        cid: Cid,
        nationality: u8,
    }

    // Storing global head at 0u8
    mapping head: u8 => u128;
    mapping post: u128 => Post;
    // CID hash maps to comments
    mapping comments: field => Comment;

    transition create_post(cid: Cid, input: trueblind_issuer.leo/Pass.record) -> trueblind_issuer.leo/Pass.record {
        let nationality: u8 = input.nationality;
        return input then finalize (cid, nationality);
    }

    finalize create_post(cid: Cid, nationality: u8) {
        let current_head: u128 = Mapping::get_or_use(head, 0u8, 0u128);

        Mapping::set(post, current_head, Post {
            cid: cid,
            nationality: nationality,
        });

        // increment head
        Mapping::set(head, 0u8, current_head + 1u128);
    }

    transition make_comment(post_cid: Cid, cid: Cid, input: trueblind_issuer.leo/Pass.record) -> trueblind_issuer.leo/Pass.record {
        let nationality: u8 = input.nationality;
        let hash: field = Poseidon2::hash_to_field(post_cid);
        return input then finalize (hash, cid, nationality);
    }

    finalize make_comment(hash: field, cid: Cid, nationality: u8) {
        Mapping::set(comments, hash, Comment {
            cid: cid,
            nationality: nationality,
        });
    }

    transition hash_cid(cid: Cid) -> field {
        return Poseidon2::hash_to_field(cid);
    }
}
