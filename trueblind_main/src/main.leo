// The 'trueblind_main' program.
import trueblind_issuer.leo;

program trueblind_main.aleo {

    struct Post {
        cid: u128,
        nationality: u8,
    }

    struct Comment {
        cid: u128,
        nationality: u8,
    }

    // Storing global head at 0u8
    mapping head: u8 => u128;
    mapping post: u128 => Post;
    // CID maps to comments
    mapping comments: u128 => Comment;

    transition create_post(cid: u128, input: trueblind_issuer.leo/Pass.record) -> trueblind_issuer.leo/Pass.record {
        let nationality: u8 = input.nationality;
        return input then finalize (cid, nationality);
    }

    finalize create_post(cid: u128, nationality: u8) {
        let current_head: u128 = Mapping::get_or_use(head, 0u8, 0u128);

        Mapping::set(post, current_head, Post {
            cid: cid,
            nationality: nationality,
        });

        // increment head
        Mapping::set(head, 0u8, current_head + 1u128);
    }

    transition comment(cid: u128, cid_comment: u128, input: trueblind_issuer.leo/Pass.record) -> trueblind_issuer.leo/Pass.record {
        let nationality: u8 = input.nationality;
        return input then finalize (cid, cid_comment, nationality);
    }

    finalize comment(cid: u128, cid_comment: u128, nationality: u8) {
        Mapping::set(comments, cid, Comment {
            cid: cid,
            nationality: nationality,
        });
    }
}
