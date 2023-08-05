/* While the core idea of a composable is to make compolex code reusable,
I also like using them to make the template code more readable */

import { ref, computed } from "vue"

const useHorizontalScroll = () => {
    const xScrollable = ref(null)

    let portrait = window.matchMedia("(orientation: portrait)")
    const isPortrait = ref(portrait.matches)
  
    const horizontalScroll = {
      ignore: computed(() => !xScrollable.value || isPortrait.value),
      use: (e) => {
        if (horizontalScroll.ignore.value) return
        e.preventDefault()
        xScrollable.value.scrollLeft += e.deltaY
      },
      set: () => {
        xScrollable.value.onwheel = horizontalScroll
      },
      remove: () => {
        xScrollable.value.onwheel = null;
      }
    }
    portrait.addEventListener("change", (e) => {
      isPortrait.value = e.matches
      if (xScrollable.value && horizontalScroll.ignore.value) horizontalScroll.remove()
      else if (xScrollable.value) horizontalScroll.set()
    })
  
    return {
      xScrollable,
      horizontalScroll
    };
  }

  export default useHorizontalScroll