global.mouse_occupied = 0
global.mouse_occupied_changed = false
lastMOccupiedInterim = 0
global.lastMouseOccupied = 0

sample = 44100;
groanBuffer = buffer_create(137280,buffer_fast,1)
buffer_fill(groanBuffer,0,buffer_u8,Groan2,137280)
buffer_seek(groanBuffer, buffer_seek_start, 0);
// Preload samples when initializing
snd = Groan2;



// Read samples into an array (handling stereo)
num_channels = 2;
bytes_per_sample = 2; // 16-bit audio
num_frames = buffer_get_size(groanBuffer) / (bytes_per_sample * num_channels);



// Store samples in a 2D array: [frame][channel]
sampless = array_create(num_frames);

for (var i = 0; i < num_frames; i++) {
    samples[i] = array_create(num_channels);
    for (var c = 0; c < num_channels; c++) {
        samples[i][c] = buffer_read(groanBuffer, buffer_s16) / 32768.0; // Normalize to [-1, 1]
    }
}
groanID = audio_create_buffer_sound(groanBuffer,buffer_u8,sample,0,buffer_get_size(groanBuffer),audio_stereo);

sound_instance = audio_play_sound(groanID, 1,1);
start_time = current_time;

