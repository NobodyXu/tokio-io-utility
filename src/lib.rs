// only enables the nightly `doc_cfg` feature when
// the `docsrs` configuration attribute is defined
#![cfg_attr(docsrs, feature(doc_cfg))]

/// Replacement for [`std::task::ready`].
#[macro_export]
macro_rules! ready {
    ($e:expr) => {
        match $e {
            Poll::Ready(t) => t,
            Poll::Pending => return Poll::Pending,
        }
    };
}

mod async_read_utility;
mod async_write_utility;
mod io_slice_ext;

#[cfg(feature = "mpsc")]
#[cfg_attr(docsrs, doc(cfg(feature = "mpsc")))]
pub mod queue;

pub use async_read_utility::*;
pub use async_write_utility::write_vectored_all;
pub use io_slice_ext::{IoSliceExt, IoSliceMutExt};
