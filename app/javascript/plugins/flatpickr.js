import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

const initFlatpickr = () => {
  const bookings = document.querySelector(".booking");
  if (bookings) {
      const disableDateArray = [];

      JSON.parse(bookings.dataset.bookings).forEach((booking) => {
        console.log(booking.beginning_date);
        const disableDateObject = {};
        disableDateObject["from"] = booking.beginning_date;
        disableDateObject["to"] = booking.ending_date;
        console.log(disableDateObject);
        disableDateArray.push(disableDateObject);
    });

     flatpickr("#range_start", {
        altInput: true,
        plugins: [new rangePlugin({ input: "#range_end"})],
         disable: disableDateArray
     });
  }

}

export { initFlatpickr };
